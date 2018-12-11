Received: from eggs.gnu.org ([2001:4830:134:3::10]:52365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWiEx-0006nw-0A
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWiEt-00081p-1L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:38:22 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWiEs-00081H-Im
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:38:18 -0500
Received: by mail-oi1-x242.google.com with SMTP id u18so11976070oie.10
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 05:38:18 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <418afa14-4cea-e95e-e646-43d105ffc5c7@linaro.org>
Date: Tue, 11 Dec 2018 07:38:13 -0600
MIME-Version: 1.0
In-Reply-To: <20181210152829.29271-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/13] tests/tcg: add softmmu awareness
 to Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, jcmvbkbc@gmail.com, michael@walle.cc, amarkovic@wavecomp.com, edgar.iglesias@gmail.com, shorne@gmail.com, aurelien@aurel32.net

On 12/10/18 9:28 AM, Alex Bennée wrote:
> +# For softmmu targets we inculde a different Makefile fragement as the

include.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
