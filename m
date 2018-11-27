Received: from eggs.gnu.org ([2001:4830:134:3::10]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRccT-0005wh-9Z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRccP-0007Qf-8D
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRccP-0007P6-2b
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
	<1543312923-3074-2-git-send-email-liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 13:37:24 +0100
In-Reply-To: <1543312923-3074-2-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Tue, 27 Nov 2018 02:02:02 -0800")
Message-ID: <87d0qqr917.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw: pc: use TYPE_XXX instead of
 constant strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org

Li Qiang <liq3ea@gmail.com> writes:

> TYPE_VMMOUSE is defined in vmmouse.c currently, move it
> to pc.h in order to use it in pc.c.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
