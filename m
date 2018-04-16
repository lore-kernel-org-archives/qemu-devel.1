Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f7z6z-0004an-90
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f7z6u-0005L0-M0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:03:41 -0400
Date: Mon, 16 Apr 2018 10:03:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180416080334.uu74ibkzhgbtjoba@sirius.home.kraxel.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-35-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180415234307.28132-35-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 34/41] hw/usb: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Sun, Apr 15, 2018 at 08:43:00PM -0300, Philippe Mathieu-Daud=E9 wrote:
> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include=
/hw/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
