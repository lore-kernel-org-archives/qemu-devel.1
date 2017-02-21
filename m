Received: from eggs.gnu.org ([2001:4830:134:3::10]:46206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cgAuY-0007Vm-I1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cgAuV-0002ZB-Jj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:55:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cgAuV-0002Z0-Db
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:55:19 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170220185020.774-4-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Mon, 20 Feb 2017 18:50:18 +0000")
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 21 Feb 2017 14:55:14 +0100
Message-ID: <87efyrodh9.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/5] slirp: Common lhost/fhost union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The socket structure has a pair of unions for lhost and fhost
> addresses; the unions are identical so split them out into
> a separate union declaration.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
