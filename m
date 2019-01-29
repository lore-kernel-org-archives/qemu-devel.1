Received: from eggs.gnu.org ([209.51.188.92]:56874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goTER-0001jj-EK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goTEP-0001gs-Ac
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:15:15 -0500
References: <1548327184-13416-1-git-send-email-thuth@redhat.com>
	<4aa7084c-3134-ec7b-a3ac-556a5ba9a7b7@oracle.com>
	<8766ee08-9bba-cad3-d3a9-fc0468f61b82@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <095ef44d-7fc3-246d-4af2-d71c9f097949@vivier.eu>
Date: Tue, 29 Jan 2019 14:14:02 +0100
MIME-Version: 1.0
In-Reply-To: <8766ee08-9bba-cad3-d3a9-fc0468f61b82@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Fix LGPL information in the
 file headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

On 29/01/2019 14:03, Thomas Huth wrote:
> On 2019-01-29 13:51, Liam Merwick wrote:
>> On 24/01/2019 10:53, Thomas Huth wrote:
>>> It's either "GNU *Library* General Public version 2" or "GNU Lesser
>>> General Public version *2.1*", but there was no "version 2.0" of the
>>
>> Should the word "License" be after both instances of "Public" above ?
>>
>>> "Lesser" library. So assume that version 2.1 is meant here.
>>
>> '"Lesser" library.' -> '"Lesser" license.' ?
> 
> Right, thanks a lot for noticing!
> 
> Laurent, could you please fix this when you pick this patch up? Or shall
> I send a v2?
>

Send a v2, please. So I'll be sure it will be properly written.

Thanks,
Laurent
