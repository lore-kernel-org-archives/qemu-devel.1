Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gKgLC-0007HD-R7
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gKgL9-0006M8-OY
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:11:06 -0500
Date: Thu, 8 Nov 2018 10:10:05 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181108091005.4rovcyb7sdvfxz6g@kamzik.brq.redhat.com>
References: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
	<1540663650-106694-5-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540663650-106694-5-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V5 4/5] hw/arm/virt: Use the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Sun, Oct 28, 2018 at 02:07:29AM +0800, Peng Hao wrote:
> add pvpanic device in aarch64 virt machine.

Why only aarch64 and not also arm?

Thanks,
drew
