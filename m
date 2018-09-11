Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziMN-000847-RS
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzi7N-00046D-7A
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:50:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:39998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzi7M-000430-UT
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:50:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id s13-v6so12182930pfi.7
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:50:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-7-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4ae03345-f422-ad88-dd3a-0e7f44a2c3de@twiddle.net>
Date: Tue, 11 Sep 2018 05:50:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-7-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/12] atomic: fix comment
 s/x64_64/x86_64/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
