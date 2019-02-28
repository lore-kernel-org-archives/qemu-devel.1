Received: from eggs.gnu.org ([209.51.188.92]:40450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzHeL-0001H4-T2
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzHeJ-0002XL-BZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:06:41 -0500
References: <155129014351.2181.16531275718275765030@49fa7ef69f7b>
	<d29adfb8-e194-54af-5f08-b4accb5df790@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fd94511-8634-fa0a-0cfc-6d7a83d57f9c@redhat.com>
Date: Thu, 28 Feb 2019 10:06:13 +0100
MIME-Version: 1.0
In-Reply-To: <d29adfb8-e194-54af-5f08-b4accb5df790@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/34] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, fam@euphon.net
Cc: qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, palmer@sifive.com, richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de

On 28/02/19 09:37, Thomas Huth wrote:
> On 27/02/2019 18.55, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190222141024.22217-1-kbastian@mail.uni-paderborn.de/
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
> 
>  Fam, Paolo,
> 
> Patchew is really going wild these days. It replied 32 times to this
> patch series - quite a bit annoying. Could this be fixed, please?

I have a fix, I haven't deployed it yet to patchew.org though.

Paolo
