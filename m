Received: from eggs.gnu.org ([2001:4830:134:3::10]:35636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeO0o-0003mh-4t
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeO0k-0003lG-8d
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:34:58 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeO0k-0003kw-1q
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:34:54 -0500
Received: by mail-pg0-x241.google.com with SMTP id g16so3060412pgn.7
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:34:53 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f14c3ed4-04cb-d15d-1002-32072a272fdb@linaro.org>
Date: Wed, 24 Jan 2018 08:34:50 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/22] include/fpu/softfloat: add some
 float16 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/24/2018 05:13 AM, Alex Bennée wrote:
> This defines the same set of common constants for float 16 as defined
> for 32 and 64 bit floats. These are often used by target helper
> functions. I've also removed constants that are not used by anybody.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2
>   - fixup constants, remove unused onces
> ---
>  include/fpu/softfloat.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
