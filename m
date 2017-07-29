Received: from eggs.gnu.org ([2001:4830:134:3::10]:38540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbFyF-00017w-0T
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbFyA-0008MZ-6d
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:51:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-17-f4bug@amsat.org>
	<7100714b-6789-15e4-f883-9e8684ddc9e7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <07a7006e-394d-adfe-0525-b0daa008bd43@amsat.org>
Date: Fri, 28 Jul 2017 21:50:56 -0300
MIME-Version: 1.0
In-Reply-To: <7100714b-6789-15e4-f883-9e8684ddc9e7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/47] MAINTAINERS: add missing entry for
 gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 07/28/2017 09:00 AM, Paolo Bonzini wrote:
> On 28/07/2017 07:35, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9670a3901a..653c2a1db1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1320,6 +1320,7 @@ L: qemu-devel@nongnu.org
>>   S: Odd Fixes
>>   F: gdbstub*
>>   F: gdb-xml/
>> +F: scripts/qemugdb/
> 
> This is unrelated.  It's for debugging QEMU, while the others are for
> debugging QEMU guests.

Thank for clarifying it, dropped.

> 
> Paolo
> 
>>   Memory API
>>   M: Paolo Bonzini <pbonzini@redhat.com>
>>
> 
