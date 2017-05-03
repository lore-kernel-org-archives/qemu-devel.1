Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5mVW-0008WT-Ke
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5mVT-00027G-Gt
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:07:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:43226)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5mVT-00026a-4R
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:07:19 -0400
In-Reply-To: <20170502143706.GL22502@stefanha-x1.localdomain>
References: <20170502061649.6668.93083.stgit@PASHA-ISP>
	<20170502143706.GL22502@stefanha-x1.localdomain>
MIME-Version: 1.0
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Wed, 03 May 2017 08:07:15 +0300
Message-ID: <96fe9706-4846-488e-9e72-a37949f87444@ispras.ru>
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] maintainers: add maintainer for replay*
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dovgaluk@ispras.ru, armbru@redhat.com

Indeed=2E I missed these ones=2E

=E2=81=A3=D0=9E=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=
=D1=8E BlueMail =E2=80=8B

=D0=9D=D0=B0 2 =D0=9C=D0=B0=D0=B9 2017 =D0=B3=2E=
, 17:37, =D0=B2 17:37, Stefan Hajnoczi <stefanha@gmail=2Ecom> =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:=D0=BF>On Tue, May 02, 2017 at 09:16:49AM +0=
300, Pavel Dovgalyuk wrote:
>> Updating MAINTAINERS to set Pavel Dovgalyuk =
as record/replay
>maintainer=2E
>> 
>> Signed-off-by: Pavel Dovgalyuk <pave=
l=2Edovgaluk@ispras=2Eru>
>> ---
>>  MAINTAINERS |    9 +++++++++
>>  1 fil=
e changed, 9 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>>=
 index a1d2b3a4d3=2E=2E8be1c74ac5 100644
>> --- a/MAINTAINERS
>> +++ b/MAIN=
TAINERS
>> @@ -1546,6 +1546,15 @@ F: net/colo*
>>  F: net/filter-rewriter=
=2Ec
>>  F: net/filter-mirror=2Ec
>>  
>> +Record/replay
>> +M: Pavel Dovga=
lyuk <pavel=2Edovgaluk@ispras=2Eru>
>> +W: http://wiki=2Eqemu=2Eorg/Feature=
s/record-replay
>> +S: Supported
>> +F: replay/*
>> +F: block/blkreplay=2Ec=

>> +F: net/filter-replay=2Ec
>> +F: include/sysemu/replay=2Eh
>
>+ F: docs=
/replay=2Etxt
>+ F: stubs/replay=2Ec
>
>Are these missing?
