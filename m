Received: from eggs.gnu.org ([2001:4830:134:3::10]:48934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn924-0003af-DB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn921-0003hN-Cf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:52:12 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn921-0003h1-7n
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:52:09 -0400
Received: by mail-qk0-x241.google.com with SMTP id o63so6127606qkb.5
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:52:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817172249.31cf5e3d@nial.brq.redhat.com>
	<e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
	<20170830155008.1babd407@nial.brq.redhat.com>
	<bef4e017-02f3-62c4-1621-ec118709717c@amsat.org>
	<20170830181906.GB979@jhogan-linux.le.imgtec.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e3c61b4-8564-7f10-d345-5bcf68203d94@amsat.org>
Date: Wed, 30 Aug 2017 16:52:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170830181906.GB979@jhogan-linux.le.imgtec.org>
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
To: James Hogan <james.hogan@imgtec.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi James,

On 08/30/2017 03:19 PM, James Hogan wrote:
[...]
>>     git://github.com/philmd/qemu.git tags/mips-qomify-20170830
> 
> A sanity check of your branch doesn't reveal any obvious regressions
> when booting a Malta KVM guest kernel with KVM.

Thank you for your time to test this!

Does that mean I can add your Tested-by: to the series?

Regards,

Phil.
