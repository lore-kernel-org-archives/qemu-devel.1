Received: from eggs.gnu.org ([2001:4830:134:3::10]:47202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHtNI-0004my-Bz
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHtNC-00014O-N1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:29:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHtNB-00011z-8D
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:29:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so15148293wme.5
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:29:32 -0700 (PDT)
References: <20181031121443.605-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ee53ee3-246f-d282-91b8-d0f99e307803@redhat.com>
Date: Wed, 31 Oct 2018 17:29:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181031121443.605-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] decodetree improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de

On 31/10/18 13:14, Richard Henderson wrote:
> All three patches have appeared on list before, though not all
> at once in the same series.  This is all cleanup suggested by
> the ongoing risc-v work.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>    decodetree: Add !extern flag to argument sets
>    decodetree: Remove "insn" argument from trans_* expanders
>    decodetree: Allow multiple input files

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
