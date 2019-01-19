Received: from eggs.gnu.org ([209.51.188.92]:57932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkxZt-00048z-7w
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 15:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkxZs-0005hD-F4
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 15:50:53 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkxZs-0005gi-7H
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 15:50:52 -0500
Received: by mail-pl1-x636.google.com with SMTP id g9so7910330plo.3
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 12:50:51 -0800 (PST)
References: <CADCM7VHNg1y_bixYKZOaFnS5_Jgig-==tK_ZpT3jk8Q0aVsgFg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5cad9e5e-853b-2ef7-d0d7-8b072d6277ef@linaro.org>
Date: Sun, 20 Jan 2019 07:50:44 +1100
MIME-Version: 1.0
In-Reply-To: <CADCM7VHNg1y_bixYKZOaFnS5_Jgig-==tK_ZpT3jk8Q0aVsgFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Implementing Memory Tag Extention - ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vishnu Dev <vishnudevtj@gmail.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, peter.maydell@linaro.org, alex.bennee@linaro.org

On 1/19/19 4:58 AM, Vishnu Dev wrote:
> Hello,
> I am a undergraduate Binary Exploitation enthusiast who would like to
> participate in GSoC with qemu on some security related project . While
> enquiring on IRC @agraf suggested a idea of implementing memory tag extension
> on ARM, this seems to be a good project . I have some experience reversing ARM
> binaries and exploitation on ARM architecture but have not done any open source
> contribution but I feel GSoC will be a great opportunity for me to begin and
> since I am really found of low level stuff, qemu seems to be a good
> organization to work with . also Qemu have helped me while working on ARM
> exploitation and Linux kernel Exploitation.
> 
> Is this project feasible to implement as a GSoC project this year .

I have just posted an implementation of this extension.

http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg02599.html


r~
