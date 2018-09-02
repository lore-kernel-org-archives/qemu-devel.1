Received: from eggs.gnu.org ([2001:4830:134:3::10]:43501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwWez-0003HK-PU
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwWew-0005dK-J5
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:59:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwWew-0005cc-BE
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:59:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so9640317wmc.0
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 10:59:37 -0700 (PDT)
References: <20180902123608.124586-1-ybettan@redhat.com>
	<CAFEAcA9mSb-RQMkEr8p-BEUH65Y7Y4TDbMZJkJjWoo_z-iT9sg@mail.gmail.com>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <2dc88142-38b0-4bc7-0dd1-f5b46533f84a@redhat.com>
Date: Sun, 2 Sep 2018 20:59:33 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9mSb-RQMkEr8p-BEUH65Y7Y4TDbMZJkJjWoo_z-iT9sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/4] Reformatted INFO files to fit the
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>



On 9/2/18 8:13 PM, Peter Maydell wrote:
> On 2 September 2018 at 13:36, Yoni Bettan <ybettan@redhat.com> wrote:
>> This patch make INFO files (e.g. README, CODING_STYLE etc) much more
>> readable when watched from GitHub GUI.
>>
>> ./VERSION and ./MAINTAINERS were leave untouched otherwise
>> ./scripts/get_maintainer.pl breaks.
>>
>> ./COPYING and ./COPYING.LIB were leave untouched because it look likes
>> they come from GNU and not QEMU.
> Thanks for this patch, but we don't use Markdown format.
> We use RST for docs files, but README, CODING_STYLE, etc
> are just plain text and fine as they are I think.

Thanks for your reply.
I sent a V2 patch before I have noticed your response so if you could 
please copy your response to the V2 mail I will appreciate it.

Thanks,
Yoni
>
> -- PMM
