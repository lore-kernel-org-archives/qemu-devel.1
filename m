Received: from eggs.gnu.org ([2001:4830:134:3::10]:36189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN4Xq-0000vO-NN
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN4Xl-00013m-Pm
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:49:14 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:36159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN4Xl-00013a-Lp
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:49:09 -0400
Received: by mail-qk0-x230.google.com with SMTP id g83so44176755qkb.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:49:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
	<1497468113-2874-2-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7b5278e2-9624-2faa-b888-eaa23492c405@twiddle.net>
Date: Mon, 19 Jun 2017 14:49:06 -0700
MIME-Version: 1.0
In-Reply-To: <1497468113-2874-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] include/exec/poison: Add missing
 TARGET defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/14/2017 12:21 PM, Thomas Huth wrote:
>   #pragma GCC poison TARGET_CRIS
>   #pragma GCC poison TARGET_LM32

Missing HPPA and TILEGX.


r~
