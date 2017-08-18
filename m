Received: from eggs.gnu.org ([2001:4830:134:3::10]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dinU9-0000xl-By
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dinU4-0007NA-GG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:03:13 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dinU4-0007Mm-A6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:03:08 -0400
Received: by mail-qt0-x244.google.com with SMTP id v49so3026325qtc.4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 13:03:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817043102.6322-3-f4bug@amsat.org>
	<20170817163830.1a6f32ed@nial.brq.redhat.com>
	<df43cc8b-70d1-5ae5-371c-8ca6318231df@amsat.org>
Message-ID: <d311ba1a-b494-d1bd-da4f-89ed52ede072@amsat.org>
Date: Fri, 18 Aug 2017 17:03:03 -0300
MIME-Version: 1.0
In-Reply-To: <df43cc8b-70d1-5ae5-371c-8ca6318231df@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Hi Igor,

On 08/17/2017 12:06 PM, Philippe Mathieu-Daudé wrote:
>>> no logical change, only code movement (and fix a comment typo).
> 
>> while at that fix checkpatch errors or
>> first fix checkpatch noted issues in cpu.h and then move it in next 
>> patch to internal.h

After asking confirmation on IRC these 3 checkpatch issues are false 
positives, and I'm not fluent in Perl to fix it, so I'll add a comment 
about it in the next series cover.

Regards,

Phil.
