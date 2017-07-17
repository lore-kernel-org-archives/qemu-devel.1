Received: from eggs.gnu.org ([2001:4830:134:3::10]:45831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXA8z-0000AU-SP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXA8x-0008Im-9k
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXA8x-0008IC-3o
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBB5C61BAC
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:49:13 +0000 (UTC)
Date: Mon, 17 Jul 2017 14:49:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170717174905.GW6020@localhost.localdomain>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1500279971-13875-2-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Jul 17, 2017 at 04:26:01PM +0800, Peter Xu wrote:
> We have merely all the stuff, but this one is missing. Add it in.
>=20
> Am going to use this new helper for MigrationParameters fields, since
> most of them are int64_t.
>=20
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Assuming that this will get merged through the migration tree:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
