Received: from eggs.gnu.org ([2001:4830:134:3::10]:48076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn4Bk-0004Rw-46
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn4Be-0005dw-MJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:41:52 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn4Be-0005cY-Hv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:41:46 -0400
Received: by mail-qt0-x244.google.com with SMTP id u11so5293306qtu.2
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 07:41:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817172249.31cf5e3d@nial.brq.redhat.com>
	<e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
	<20170830155008.1babd407@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bef4e017-02f3-62c4-1621-ec118709717c@amsat.org>
Date: Wed, 30 Aug 2017 11:41:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170830155008.1babd407@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Igor,

On 08/30/2017 10:50 AM, Igor Mammedov wrote:
>> [...]
>>>> Also I couldn't test it with KVM.
[..]
>>
>> I'll wait to see if there is some KVM feedback from imgtec folks before
>> spaming a v2.
> 
> Philippe,
> 
> Are you going to respin series soon?

I'm waiting 2.11 officially announced open to send it which should be 
tomorrow, in the meaning time it is available in my git repository at:

   git://github.com/philmd/qemu.git tags/mips-qomify-20170830

Regards,

Phil.
