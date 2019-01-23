Received: from eggs.gnu.org ([209.51.188.92]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPxp-0004sk-9m
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPwB-0000Eb-I9
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:19:56 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:38480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmPwB-0000EQ-CO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:19:55 -0500
Received: by mail-pg1-x52f.google.com with SMTP id g189so1643515pgc.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:19:55 -0800 (PST)
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-33-yang.zhong@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9f04b01-1723-7044-5ab9-8e3abf4a6231@linaro.org>
Date: Wed, 23 Jan 2019 13:19:51 -0800
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-33-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 32/44] build: convert usb.mak to
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com

On 1/22/19 10:56 PM, Yang Zhong wrote:
>  default-configs/alpha-softmmu.mak       |  1 -

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
