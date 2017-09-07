Received: from eggs.gnu.org ([2001:4830:134:3::10]:42474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dpyMm-0002ji-Cx
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dpyMh-00070d-N4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:05:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dpyMh-0006ys-Hy
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:05:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87F4EZl018557
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 11:05:09 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cu38bg4e1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:05:09 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 11:05:09 -0400
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-12-git-send-email-armbru@redhat.com>
	<CAJ+F1C+JyRBxc-cv0ko1zqNnNt6N0h5OhrLM2GdVT3yLocgNKw@mail.gmail.com>
	<87inh82anm.fsf@dusky.pond.sub.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 7 Sep 2017 11:05:05 -0400
MIME-Version: 1.0
In-Reply-To: <87inh82anm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <898fa7aa-6923-04ab-637e-4232a6f4c9f4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/16] qapi-schema: Collect TPM stuff in
 qapi/tpm.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On 08/28/2017 07:29 AM, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> On Thu, Aug 24, 2017 at 9:23 PM Markus Armbruster <armbru@redhat.com> =
wrote:
>>
>>> Sadly, we don't have a TPM maintainer, not even a MAINTAINERS entry.
>>> Create one, and mark it orphaned.
>>>
>>>
>> This is also proposed in:
>> http://patchew.org/QEMU/20170728053610.15770-1-f4bug@amsat.org/
> Forgot about that one.
>
> My patch additionally has "F: include/hw/acpi/tpm.h", and of course the
> new "qapi/tpm.json", and it's not marked "RFC".
>
>> Stefan Berger, any chance you declare yourself a TPM maintainer?
> Please?

Ok, I'll do it.

   Stefan

>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Thanks!
>
