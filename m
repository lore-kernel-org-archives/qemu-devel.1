Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGgA-0000rJ-Qg
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGg7-00081R-Nu
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:00:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
Date: Thu, 20 Jul 2017 08:59:55 -1000
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 03/23] softfloat3c: dos2unix
 all files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 07/20/2017 05:04 AM, Alex Bennée wrote:
> This is a massive but mechanical patch, the result of:
> 
>    (cd fpu/softfloat3c; and find . | xargs dos2unix)
>    (cd include/fpu/softfloat3c; and dos2unix *)
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---

Really shouldn't this have been part of the import?


r~
