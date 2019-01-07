Received: from eggs.gnu.org ([209.51.188.92]:39887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1ggPkS-0002ZS-Fx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1ggPkR-0005IG-QV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:55:00 -0500
References: <154681539681.475.7900177304020568757@02a1dbf831e2>
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <45bd563b-881a-5308-dca8-9aaad94b7ebb@gmail.com>
Date: Mon, 7 Jan 2019 07:54:52 +0000
MIME-Version: 1.0
In-Reply-To: <154681539681.475.7900177304020568757@02a1dbf831e2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-arm@nongnu.org



On 06/01/2019 22:56, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/d19529f5-841e-ea06-fe7d-86ccfd528817@gmail.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:

The files being touched have lots of coding style problems already.  I'm
avoiding i) fixing these in the same diff for clarity and ii) in the
case of IH_TYPE_KERNEL_NOLOAD, following existing formatting.

I'll send v5 with the loadaddr api documentation formatting fix.

Nick
