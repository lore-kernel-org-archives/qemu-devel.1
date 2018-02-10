Received: from eggs.gnu.org ([2001:4830:134:3::10]:60520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekOeW-0001eA-Jo
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 01:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekOeV-00077L-QB
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 01:28:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ekOeV-000777-MH
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 01:28:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180209050329.15094-1-armbru@redhat.com>
	<CAFEAcA84hpU_Abf_8dOGFTxD1iRzey2+b1HL7RZTf=LFiEcyhQ@mail.gmail.com>
Date: Sat, 10 Feb 2018 07:28:45 +0100
In-Reply-To: <CAFEAcA84hpU_Abf_8dOGFTxD1iRzey2+b1HL7RZTf=LFiEcyhQ@mail.gmail.com>
	(Peter Maydell's message of "Fri, 9 Feb 2018 11:46:07 +0000")
Message-ID: <873729l5nm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v3 00/20] Miscellaneous patches for
 2018-02-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 9 February 2018 at 05:03, Markus Armbruster <armbru@redhat.com> wrote:
>> The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c96:
>>
>>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-02-08 14:31:51 +0000)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-02-07-v3
>>
>> for you to fetch changes up to 59a92828ad355a0194248cab9ce98dddced04363:
>>
>>   Move include qemu/option.h from qemu-common.h to actual users (2018-02-09 05:07:33 +0100)
>>
>> ----------------------------------------------------------------
>> Miscellaneous patches for 2018-02-07
>>
>
> Hi. This seems to have the same OSX build errors as v1:

Any chance we can get OSX covered in Patchew?
