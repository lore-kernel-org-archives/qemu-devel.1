Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f6Pbu-0005yx-7l
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 19:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f6Pbt-00039V-1u
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 19:57:06 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:43788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f6Pbs-00038i-Pw
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 19:57:04 -0400
Received: by mail-pl0-x22e.google.com with SMTP id a39-v6so2560395pla.10
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 16:57:04 -0700 (PDT)
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<e863cce3-d06e-f225-eb25-212729c5f05f@linaro.org>
	<20180411152942.GA4480@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a725be3-4ca1-a883-7313-cee1dc5825c2@linaro.org>
Date: Thu, 12 Apr 2018 09:56:53 +1000
MIME-Version: 1.0
In-Reply-To: <20180411152942.GA4480@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Avoid integer overflow in
 next_page_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/12/2018 01:29 AM, Emilio G. Cota wrote:
> To ease an eventual merge I'll be updating the patches' R-b tags as
> they come in this branch:
>   https://github.com/cota/qemu/tree/next_page_overflow-r-b
> 
> BTW to avoid conflicts we should merge this before the translator loop
> conversion series; I'll make that clear when I send a new version
> of that patch set.

Right-o.  Thanks.  We'll get these in right away once development starts again
so that you don't have to carry it long.


r~
