Received: from eggs.gnu.org ([209.51.188.92]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPxs-0004sk-0L
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPvN-0008R1-Ae
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:19:05 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmPvN-0008QW-35
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:19:05 -0500
Received: by mail-pf1-x42b.google.com with SMTP id q1so1812689pfi.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:19:04 -0800 (PST)
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-31-yang.zhong@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <955f6e39-4b89-fe33-bb86-fbd388a50236@linaro.org>
Date: Wed, 23 Jan 2019 13:19:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-31-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 30/44] build: convert pci.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, pbonzini@redhat.com, sameo@linux.intel.com

On 1/22/19 10:56 PM, Yang Zhong wrote:
>  default-configs/alpha-softmmu.mak       |  2 +-

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
