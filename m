Received: from eggs.gnu.org ([2001:4830:134:3::10]:32927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHwt8-0008Tn-J1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHwt5-0002DX-Av
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHwt5-0002D3-1S
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:14:47 -0400
Date: Wed, 31 Oct 2018 17:14:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031201440.GB30771@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181030150453.9344-10-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/10] hw/i386: add pc-i440fx-3.1 &
 pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 30, 2018 at 07:04:52PM +0400, Marc-Andr=E9 Lureau wrote:
> The following patch is going to add compatiblity parameters.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm really surprised we spent the whole 3.1 development cycle
without any change that required adding pc-*-3.1 machines.

--=20
Eduardo
