Received: from eggs.gnu.org ([2001:4830:134:3::10]:38062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iSW-0005YH-8c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iSQ-00053l-Pd
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:44:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170630183736.13222-1-rth@twiddle.net>
	<1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a062a2ec-6469-d7d6-12f4-6a0aedf20e7a@amsat.org>
Date: Thu, 26 Oct 2017 10:44:10 -0300
MIME-Version: 1.0
In-Reply-To: <1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org

>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/ppc/translate.c | 23 ++++++++---------------
>>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> *ping*
> 
> Richard, David, any chance that we can still get this in for 2.11? I
> think this would be quite a nice performance improvement for PPC TCG...

This still miss a Reviewed-by tag ;)
