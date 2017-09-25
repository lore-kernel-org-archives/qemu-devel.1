Received: from eggs.gnu.org ([2001:4830:134:3::10]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLmD-0000PE-7p
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLmA-0004a6-4G
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:17:53 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-16-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2544f859-9299-f005-a0bb-b099138d1611@redhat.com>
Date: Mon, 25 Sep 2017 07:17:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-16-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/34] hw/i2c: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i2c/pm_smbus.c   | 1 -
>  hw/i2c/smbus_ich9.c | 1 -
>  2 files changed, 2 deletions(-)
>

Reviewed-by: Thomas Huth <thuth@redhat.com>
