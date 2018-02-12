Received: from eggs.gnu.org ([2001:4830:134:3::10]:52070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKMm-0002PE-MX
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKMi-0002KY-P1
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:06:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elKMi-0002KI-Jv
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:06:16 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-17-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd6d1607-5a6d-488b-2e16-7536be9c1cc7@redhat.com>
Date: Mon, 12 Feb 2018 14:06:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/29] qapi: Generate in source order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> The generators' conversion to visitors (merge commit 9e72681d16)
> changed the processing order of entities from source order to
> alphabetical order.  The next commit needs source order, so change it
> back.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
