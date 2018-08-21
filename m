Received: from eggs.gnu.org ([2001:4830:134:3::10]:47132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frziD-0007o8-Mr
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzUY-00056f-3J
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:46:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frzUX-00056R-Rp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:46:09 -0400
Date: Tue, 21 Aug 2018 07:46:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821054606.bjfykbywqliupdul@sirius.home.kraxel.org>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180704153919.12432-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] ui/vnc: Remove useless parenthesis
 around DIV_ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Wed, Jul 04, 2018 at 12:39:17PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Patch created mechanically by rerunning:
>=20
>   $  spatch --sp-file scripts/coccinelle/round.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Added to ui queue.

thanks,
  Gerd
