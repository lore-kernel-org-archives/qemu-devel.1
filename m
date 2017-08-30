Received: from eggs.gnu.org ([2001:4830:134:3::10]:37764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAE3-0005ok-QO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAE0-0008Lu-Lx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:08:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-2-f4bug@amsat.org>
	<3be12552-daf6-450f-765e-ce390c4bf3c6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f5c7cc2-16b6-4e72-707d-58b29f0f376a@amsat.org>
Date: Wed, 30 Aug 2017 18:08:32 -0300
MIME-Version: 1.0
In-Reply-To: <3be12552-daf6-450f-765e-ce390c4bf3c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/47] MAINTAINERS: add missing entry
 for documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 07/28/2017 03:47 AM, Thomas Huth wrote:
> On 28.07.2017 07:35, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>
>> because having only a "Build system architecture" entry in Documentation seems
>> odd to me, so RFC.
>>
>>   MAINTAINERS | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5ea273f899..972118e70b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1886,6 +1886,9 @@ W: http://patchew.org/QEMU/
>>   
>>   Documentation
>>   -------------
>> +Overall
>> +F: docs/
> 
> But it also does not make sense to add such an entry without a "M:"
> line, does it?

Indeed, dropped.
