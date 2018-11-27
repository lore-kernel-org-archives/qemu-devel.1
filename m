Received: from eggs.gnu.org ([2001:4830:134:3::10]:59134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbeM-0001ws-5u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbeH-0004dq-EG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:35:30 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-5-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e248dae5-445a-3a39-e395-36f9d090da9b@vivier.eu>
Date: Tue, 27 Nov 2018 12:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 04/25] MAINTAINERS:
 Add missing entries for the Xilinx ZynqMP machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
