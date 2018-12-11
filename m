Received: from eggs.gnu.org ([2001:4830:134:3::10]:52824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWiGZ-0007gw-DI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWiGU-0000hB-0Z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:40:02 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWiGS-0000fZ-QO
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:39:57 -0500
Received: by mail-oi1-x241.google.com with SMTP id h25so12032594oig.1
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 05:39:56 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd80219a-b015-5d41-8fbc-2b3f33bdbb89@linaro.org>
Date: Tue, 11 Dec 2018 07:39:52 -0600
MIME-Version: 1.0
In-Reply-To: <20181210152829.29271-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/13] tests/tcg: add QEMU_OPT option
 for test runner
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
> This will allow tests to modify the QEMU invocation with for example
> different -cpu stazas without having to define a whole new set of

"stanzas"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
