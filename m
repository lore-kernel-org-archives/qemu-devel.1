Received: from eggs.gnu.org ([2001:4830:134:3::10]:41268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLhr-0006tB-38
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLhn-0002gk-Uf
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:13:23 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-11-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea7fa662-5167-a9ed-93c8-50603d874d83@redhat.com>
Date: Mon, 25 Sep 2017 07:13:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/34] amd_iommu: avoid needless includes
 in header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> instead move them to the source file
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/amd_iommu.h | 5 -----
>  hw/i386/amd_iommu.c | 5 ++++-
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
