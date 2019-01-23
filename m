Received: from eggs.gnu.org ([209.51.188.92]:37984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPyR-0005Ht-6Q
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPjL-0003Ba-G3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:06:41 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmPjH-0002z2-Tu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:06:36 -0500
Received: by mail-pl1-x642.google.com with SMTP id e11so1764795plt.11
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:06:20 -0800 (PST)
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-5-yang.zhong@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08e88cba-4ccc-1670-d170-3d1eb860d8af@linaro.org>
Date: Wed, 23 Jan 2019 13:06:14 -0800
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-5-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 04/44] hw/arm/Makefile.objs:
 CONFIG_VIRT created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com

On 1/22/19 10:55 PM, Yang Zhong wrote:
> make virt code configurable and the new CONFIG_VIRT definitions
> added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
> in arm board.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/arm/Makefile.objs            | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
