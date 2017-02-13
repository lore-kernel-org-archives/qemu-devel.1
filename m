Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFRU-0004Xa-I9
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFRS-0002MQ-GK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdFRS-0002ME-Az
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:09:14 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20161027153217.16984-9-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 27 Oct 2016 16:32:17 +0100")
References: <20161027153217.16984-1-dgilbert@redhat.com>
	<20161027153217.16984-9-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 13:09:05 +0100
Message-ID: <87y3xa5m3i.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 8/8] slirp: VMStatify remaining except for
 loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, duanj@linux.vnet.ibm.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> This converts the remaining components, except for the loop, to VMState.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
