Received: from eggs.gnu.org ([2001:4830:134:3::10]:50134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duI4e-0000sh-2T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duI4Z-000729-5Z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:56:24 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:57188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duI4Z-00071f-12
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:56:19 -0400
Received: by mail-qk0-x233.google.com with SMTP id u7so3427011qku.13
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:56:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
	<20170915170326.5278d578@nial.brq.redhat.com>
	<20170918184213.2fd0ead5@Igors-MacBook-Pro.local>
	<20170919121125.GE21016@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <186c6ccd-5816-6859-ceae-0f2696cededa@amsat.org>
Date: Tue, 19 Sep 2017 09:56:15 -0300
MIME-Version: 1.0
In-Reply-To: <20170919121125.GE21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] generalize parsing of cpu_model
 (x86/arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

On 09/19/2017 09:11 AM, Eduardo Habkost wrote:
>> Igor Mammedov <imammedo@redhat.com> wrote:
[...]
>>> Could you merge it via machine tree?
[...]
> 
> Queued on machine-next:

Thanks Eduardo for applying the !fixup :)
