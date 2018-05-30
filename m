Received: from eggs.gnu.org ([2001:4830:134:3::10]:44199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fO7j9-0005Gh-Ey
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fO7j8-0008Id-Kb
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:29:47 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-21-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <3c9d5ad5-c723-0e84-5221-13a60f5c0e68@redhat.com>
Date: Wed, 30 May 2018 16:29:40 -0400
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-21-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/21] hw/ide: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: "open list:IDE" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 05/28/2018 07:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> There is no need to include pci.h in this file.
> (Continue f23c81073a cleanup).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: John Snow <jsnow@redhat.com>
