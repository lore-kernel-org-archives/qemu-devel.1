Received: from eggs.gnu.org ([2001:4830:134:3::10]:39131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLA8t-0002S7-Ft
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLA8q-0000c2-AK
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:23:35 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:34565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLA8q-0000bX-4g
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:23:32 -0400
Received: by mail-qt0-x232.google.com with SMTP id c10so3484178qtd.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:23:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170614052311.13785-1-rth@twiddle.net>
Message-ID: <584c2e41-a543-ad77-2154-2269e1f5952b@twiddle.net>
Date: Wed, 14 Jun 2017 08:23:27 -0700
MIME-Version: 1.0
In-Reply-To: <20170614052311.13785-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/10] TCG queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 06/13/2017 10:23 PM, Richard Henderson wrote:
> The patches from Emilio, plus the code reversions suggested by Alex.

Whee!  Alex and Emilio have found the core problem overnight.

So please disregard this pull.  I'll spin another with fixes instead of reversions.


r~
