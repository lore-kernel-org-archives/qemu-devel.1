Received: from eggs.gnu.org ([2001:4830:134:3::10]:53630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1ehNyY-0008Af-JZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1ehNxU-0006A2-Br
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:09:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1ehNxT-0004h4-RG
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:07:56 -0500
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <07d824ee-da96-8b7e-afda-d5c92f38553b@oracle.com>
Date: Fri, 2 Feb 2018 07:07:43 +0800
MIME-Version: 1.0
In-Reply-To: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nesrine Zouari <nesrine.zouari@enis.tn>, qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, stefanha@redhat.com

Hi Nesrine,

On 02/01/2018 11:30 PM, Nesrine Zouari wrote:
> Hello,
> 
> I am a computer engineering student and I am actually working on my
> graduation project at Lauterbach company. The project is about Qemu Trace
> and as a future I would like to contribute this work to the main line.
> 
> My project is divided into two parts:
> 
> 1/ Collecting the Guest trace data : The trace solution should be able to
> provide:
> 
>             a/ Instruction flow Trace
> 
>             b/ Memory read/write access

About mem read/write, there is a project panda:

https://github.com/panda-re/panda

> 
>             c/ Time Stamps.
> 
>             d/ For tracing rich operating systems that are using MMU, we
> additionally need to trace the task switches.
> 
> 2/ Sending the collected data to a third party tool for analysis.
> 
> My question is about the first part. I would like to know, which trace
> backend that better fit my use case.
> 
> 
> Regards,
> 
> -----------------------------------------------------------------------------------------
> 
> Nesrine ZOUARI
> Computer Engineering Student
> Department of Computer Engineering and Applied Mathematics
> National Engineering School of Sfax (ENIS)
> University of Sfax-Tunisia
> Tel: +216 52 620 475
> 

Dongli Zhang
