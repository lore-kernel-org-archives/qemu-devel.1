Received: from eggs.gnu.org ([209.51.188.92]:44921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gn7iu-00043Y-Ub
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gn7iu-0007Wv-8G
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:05:08 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:39708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gn7iu-0007WN-1D
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:05:08 -0500
Received: by mail-pg1-x529.google.com with SMTP id w6so4630439pgl.6
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 12:05:07 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-23-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed492073-f5d1-94dc-7bb2-478061e5ab5a@linaro.org>
Date: Fri, 25 Jan 2019 12:05:04 -0800
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-23-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/52] hw/hppa/Makefile.objs: Create
 CONFIG_* for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 1/25/19 2:06 AM, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> Add the new configs to default-configs/hppa-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-19-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/hppa-softmmu.mak | 1 +
>  hw/hppa/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
