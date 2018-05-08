Received: from eggs.gnu.org ([2001:4830:134:3::10]:46854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fGBHb-00011g-BM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fGBHa-0003r0-Ix
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:40:31 -0400
References: <20180508144948.14071-1-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <158287f9-d106-9d15-6cc0-79d350d669fc@redhat.com>
Date: Tue, 8 May 2018 18:40:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180508144948.14071-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/ide/ahci: Keep ALLWINNER_AHCI() macro
 internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 05/08/2018 10:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The ALLWINNER_AHCI() macro is only used in ahci-allwinner.c.
>=20

extra internal!

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: John Snow <jsnow@redhat.com>

Feel free to stage in trivial, thanks.
