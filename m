Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziLq-000847-HX
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziFu-0003WH-FW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:59:02 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:39140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fziFt-0003Vh-4H
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:58:58 -0400
Received: by mail-pg1-x529.google.com with SMTP id i190-v6so12231241pgc.6
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:58:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-13-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e3c9f6fd-a784-e8b9-cac6-5197330474c7@twiddle.net>
Date: Tue, 11 Sep 2018 05:58:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-13-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] configure: enable mttcg for i386
 and x86_64
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
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
