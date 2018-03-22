Received: from eggs.gnu.org ([2001:4830:134:3::10]:35118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez6yB-0001NL-UU
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez6yB-0005aQ-8Q
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:37:55 -0400
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:43811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ez6yB-0005aI-1N
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:37:55 -0400
Received: by mail-yw0-x22c.google.com with SMTP id r66so3285142ywh.10
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 13:37:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6de7c7f7-c2db-c575-53ef-18118c0f4df3@redhat.com>
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
	<20180322180940.8253-2-jcmvbkbc@gmail.com>
	<6de7c7f7-c2db-c575-53ef-18118c0f4df3@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 13:37:53 -0700
Message-ID: <CAMo8Bf+TL_LiYozskKc+EKtozA1yRnboDCUhZXoFA+Y4V+td5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] target/xtensa: add .inc. to non-top
 level source file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Mar 22, 2018 at 12:16 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/22/2018 01:09 PM, Max Filippov wrote:
>>
>> Fix definitions of existing cores and core importing script.
>
> This mentions the script...
> ...but only touches .c files.

Yeah, I initially did it in a single patch, but then split it into
two. Will merge
them back as suggested.

-- 
Thanks.
-- Max
