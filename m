Received: from eggs.gnu.org ([2001:4830:134:3::10]:39519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cbvbb-0002UB-41
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cbvbY-0006ed-0n
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:46:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cbvbX-0006eQ-Qg
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:46:11 -0500
References: <CAJSP0QWGcG9bTZZr22BEj-P_G2r4UhmNwGSfwSnwjZeTC687GQ@mail.gmail.com>
	<CAFEAcA_OJWrknC+YSsbjgcv=YtMq5GY04EcyXZt+V8eBH5TSWw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e5673883-cd68-7d4a-01fc-394c506b18a9@redhat.com>
Date: Thu, 9 Feb 2017 15:46:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_OJWrknC+YSsbjgcv=YtMq5GY04EcyXZt+V8eBH5TSWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Call for GSoC 2017 mentors & project ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 02/09/2017 07:46 AM, Peter Maydell wrote:
> On 18 January 2017 at 10:52, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> QEMU will be applying to Google Summer of Code again this year.
>>
>> Do you want to help some of the most talented university students
>> begin contributing to open source by working on our codebase and
>> joining our community?
>>
>> We need to put together a list of project ideas by February 9:
>> http://qemu-project.org/Google_Summer_of_Code_2017#Project_Ideas
> 
> Slightly late, but I had an idea last night: would "get
> Raspbian booting on our raspi2 board model" be a good
> project? Would involve some mix of bug fixing, cleaning
> up and adding device models from the raspi2 tree on github,
> and implementing missing devices. Bit of a "how long is a
> piece of string" project, but on the other hand breaks
> down easily into small parts that can all go upstream
> individually. Would suit student who likes debugging :-)
> 
> thanks
> -- PMM
> 

Who was working on this most recently? There was someone submitting
patches pretty frequently for the raspi2 board within the last year,
wasn't there?

--js
