Received: from eggs.gnu.org ([2001:4830:134:3::10]:33517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUzjz-00067E-7d
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUzjw-0007Mg-49
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUzjv-0007MS-Uf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id m54so19148qtb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:18:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-2-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f064273c-12bd-f671-6915-8fe35266c04f@twiddle.net>
Date: Tue, 11 Jul 2017 08:17:22 -1000
MIME-Version: 1.0
In-Reply-To: <20170711175937.23140-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] include/exec/exec-all: document
 common exit conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 07/11/2017 07:59 AM, Alex Bennée wrote:
> As a precursor to later patches attempt to come up with a more
> concrete wording for what each of the common exit cases would be.
> 
> CC: Emilio G. Cota<cota@braap.org>
> CC: Richard Henderson<rth@twiddle.net>
> CC: Lluís Vilanova<vilanova@ac.upc.edu>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/exec/exec-all.h | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
