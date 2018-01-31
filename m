Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egsNT-0007jT-9l
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egsNQ-0005TD-4l
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egsNP-0005SP-Vc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:24:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180110190049.5389.12984.stgit@gimli.home>
	<20180110190224.5389.18151.stgit@gimli.home>
Date: Wed, 31 Jan 2018 14:24:26 +0100
In-Reply-To: <20180110190224.5389.18151.stgit@gimli.home> (Alex Williamson's
	message of "Wed, 10 Jan 2018 12:02:24 -0700")
Message-ID: <87a7wu5fg5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/5] qapi: Create
 DEFINE_PROP_OFF_AUTO_PCIBAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, eric.auger@redhat.com

Alex Williamson <alex.williamson@redhat.com> writes:

> Add an option which allows the user to specify a PCI BAR number,
> including an 'off' and 'auto' selection.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
