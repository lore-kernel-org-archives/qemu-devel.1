Received: from eggs.gnu.org ([2001:4830:134:3::10]:47367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1drpq1-00044A-4V
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1drppw-00020o-6v
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:23:09 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1drppw-00020h-1A
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:23:04 -0400
Received: by mail-pg0-x22f.google.com with SMTP id u18so6165192pgo.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:23:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170911213328.9701-1-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a8b104d-a2db-4f8a-0e51-11a21b4bc156@twiddle.net>
Date: Tue, 12 Sep 2017 11:22:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170911213328.9701-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] move user-exec, tcg-runtime,
 atomic_template.h to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/11/2017 02:33 PM, Philippe Mathieu-Daudé wrote:
> 
> Philippe Mathieu-Daudé (4):
>   tcg: move user-exec
>   tcg: move tcg-runtime to accel/tcg/
>   tcg: move atomic_template.h to accel/tcg/
>   tcg: restrict i386 regs definitions
> 
> Thomas Huth (1):
>   tcg: Move softmmu_template.h to the accel/tcg/ folder

Queued 1-4.


r~
