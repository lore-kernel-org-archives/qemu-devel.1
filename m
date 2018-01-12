Received: from eggs.gnu.org ([2001:4830:134:3::10]:48237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ea3MI-00054Z-Tp
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ea3MI-0007bU-2x
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:43:14 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:41841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ea3MH-0007au-Uq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:43:14 -0500
Received: by mail-yb0-x243.google.com with SMTP id v76so3016210ybb.8
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:43:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515778610-18894-1-git-send-email-jcmvbkbc@gmail.com>
References: <27e44c5d-b04c-df08-bd7f-fc4089d91dcd@redhat.com>
	<1515778610-18894-1-git-send-email-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 12 Jan 2018 09:43:12 -0800
Message-ID: <CAMo8Bf+qNMHRLjFmXksqDmamCL+9H_YK_PZsP5fvZcT_C=UEBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: don't typedef DisasContext
 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

On Fri, Jan 12, 2018 at 9:36 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> This fixes build on Centos 6.
>
> Fixes: 168c12b02470 ("target/xtensa: extract core opcode translators").
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

...and thank you Peter for fixing it.

-- 
Thanks.
-- Max
