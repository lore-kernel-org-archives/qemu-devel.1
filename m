Received: from eggs.gnu.org ([2001:4830:134:3::10]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Pb-0007XG-4f
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Pa-0000Ok-Gk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:57:27 -0500
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:35121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3Pa-0000Nu-9O
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:57:26 -0500
Received: by mail-vk0-x242.google.com with SMTP id y187so10392301vkd.2
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:57:26 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8aeb404c-fba3-00f5-14f7-c96a7286b256@linaro.org>
Date: Mon, 18 Dec 2017 13:57:14 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 08/19] fpu/softfloat: move the extract
 functions to the top of the file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:56 AM, Alex Bennée wrote:
> +}
>  /*----------------------------------------------------------------------------

Watch the vertical white space.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
