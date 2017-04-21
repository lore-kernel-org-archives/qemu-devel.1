Received: from eggs.gnu.org ([2001:4830:134:3::10]:51997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1VjZ-0008ON-FJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1VjW-0002rJ-Cf
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1VjW-0002r4-5y
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:24:10 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170403171843.3363-6-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Mon, 3 Apr 2017 18:18:43 +0100")
References: <20170403171843.3363-1-dgilbert@redhat.com>
	<20170403171843.3363-6-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 21 Apr 2017 12:24:07 +0200
Message-ID: <87shl2cb3s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 5/5] slirp: VMStatify remaining except
 for loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@gnu.org, jan.kiszka@siemens.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> This converts the remaining components, except for the top level
> loop, to VMState.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I think that I had already reviewed previous version of this patch.
