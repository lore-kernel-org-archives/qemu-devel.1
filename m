Received: from eggs.gnu.org ([2001:4830:134:3::10]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31Sc-00085s-US
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31SZ-0003bI-Qq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:28:58 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d31SZ-0003as-Kf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:28:55 -0400
Received: by mail-it0-x242.google.com with SMTP id x188so21030084itb.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:28:55 -0700 (PDT)
In-Reply-To: <9d8c02d4-952b-170c-5441-626aa296a582@redhat.com>
References: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
	<9d8c02d4-952b-170c-5441-626aa296a582@redhat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CADAF517-493E-46B3-9FB1-5D5385D4711E@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 25 Apr 2017 10:28:52 -0400
Subject: Re: [Qemu-devel] [PATCH 1/9] Add ppc.risu file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On Apr 25, 2017, at 9:16 AM, Eric Blake wrote:

> On 04/24/2017 10:17 PM, G 3 wrote:
>> Add the ppc.risu file. It defines the format for various PowerPC
>> instructions.
>
> Your emails are missing In-Reply-To and References headers, which  
> means
> you posted 10 top-level threads instead of 9 replies to the 0/9 cover
> letter. Please fix that, as it becomes awkward to track a series  
> that is
> not properly threaded.

I did try to use git send-email but it failed. It was due to some  
missing perl module. The computer I had to use to test risu on is 12  
years old. I expected there to be some software incompatibilities.
