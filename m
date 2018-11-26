Received: from eggs.gnu.org ([2001:4830:134:3::10]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRJIN-0002O8-VU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRJIL-0007kK-TS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:59:35 -0500
MIME-Version: 1.0
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-5-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-5-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Nov 2018 07:58:58 -0800
Message-ID: <CAKmqyKPzxsj4oATNH4k5C23ShG4RUTWpFHHbq4+4GDo5wXNa=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 04/25] MAINTAINERS: Add missing
 entries for the Xilinx ZynqMP machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sun, Nov 25, 2018 at 12:54 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b9996ab2c..007f89f126 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -711,6 +711,9 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/xlnx*.c
>  F: include/hw/*/xlnx*.h
> +F: include/hw/ssi/xilinx_spips.h
> +F: hw/display/dpcd.c
> +F: include/hw/display/dpcd.h
>
>  ARM ACPI Subsystem
>  M: Shannon Zhao <shannon.zhaosl@gmail.com>
> --
> 2.17.2
>
>
