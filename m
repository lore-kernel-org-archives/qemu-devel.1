Received: from eggs.gnu.org ([209.51.188.92]:50254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1gd6-0004U7-Rk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1gd6-0000IZ-98
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:11:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1gd6-0000IF-2C
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:11:20 -0500
Date: Wed, 6 Mar 2019 19:11:14 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307001114.gkecoffqvbnqrrl3@localhost.localdomain>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190305172139.32662-3-peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/12] docs: Convert memory.txt to rst
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Tue, Mar 05, 2019 at 05:21:29PM +0000, Peter Maydell wrote:
> Convert the memory API documentation from plain text
> to restructured text format.
>=20
> This is a very minimal conversion: all I had to change
> was to mark up the ASCII art parts as Sphinx expects
> for 'literal blocks', and fix up the bulleted lists
> (Sphinx expects no leading space before the bullet, and
> wants a blank line before after any list).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-3-peter.maydell@linaro.org

Reviewed-by: Cleber Rosa <crosa@redhat.com>
