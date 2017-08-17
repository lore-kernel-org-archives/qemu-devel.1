Received: from eggs.gnu.org ([2001:4830:134:3::10]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diMNh-0007hi-Qs
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diMNe-00048i-MT
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:06:45 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:35943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diMNe-00048c-HV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:06:42 -0400
Received: by mail-qt0-x22f.google.com with SMTP id v29so39087102qtv.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:06:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817043102.6322-3-f4bug@amsat.org>
	<20170817163830.1a6f32ed@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df43cc8b-70d1-5ae5-371c-8ca6318231df@amsat.org>
Date: Thu, 17 Aug 2017 12:06:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170817163830.1a6f32ed@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] mips: introduce internal.h and cleanup
 cpu.h
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

>> no logical change, only code movement (and fix a comment typo).

> while at that fix checkpatch errors or
> first fix checkpatch noted issues in cpu.h and then move it in next patch to internal.h

ok will do!
