Received: from eggs.gnu.org ([209.51.188.92]:44133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1gwqvG-0008EY-JH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1gwqvF-0005jk-UQ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:10:06 -0500
Received: from thoth.sbs.de ([192.35.17.2]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1gwqvF-0005Tx-Fw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:10:05 -0500
References: <20190221155359.8247-1-davidkiarie4@gmail.com>
	<aac6b5d0-ecdd-577c-5b38-8c875ea1dffc@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6cdbaddf-57d8-3333-c9a0-7c5f46cecab7@siemens.com>
Date: Thu, 21 Feb 2019 17:09:40 +0100
MIME-Version: 1.0
In-Reply-To: <aac6b5d0-ecdd-577c-5b38-8c875ea1dffc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] snip my name and email
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, David Kiarie <davidkiarie4@gmail.com>, qemu-devel@nongnu.org
Cc: alexaltea123@gmail.com, peterx@redhat.com, mst@redhat.com

On 21.02.19 17:05, Eric Blake wrote:
> On 2/21/19 9:53 AM, David Kiarie wrote:
>> the occurrence of my name and email on the files below may have led to
>> some confusion in the reporting of a few recent bugs.
>>
>> i have therefore choosen to snip it.
> 
> Dropping an email from the copyright line makes sense; dropping the
> Copyright declaration altogether is a bit odd (the GPL works only in
> tandem with a copyright assertion) - but as you are the author of the
> line and copyright holder of your contributions, I am not in a position
> to say you are wrong in removing it, only that it looks odd.
> 

Yeah, indeed.

David, also note that you probably have been addressed because 
scripts/get_maintainer.pl will look into the git history of files that some 
patch addresses and pick up significant and/or recent contributors from there. 
There should be some opt-out statement from that, but I don't recall how.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
